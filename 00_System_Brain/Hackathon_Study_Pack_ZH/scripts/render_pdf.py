"""Render the Chinese hackathon study pack into a printable PDF.

Uses PyMuPDF directly because this workspace does not have pandoc/reportlab.
This script is intentionally small and local-only.
"""

from __future__ import annotations

import re
import textwrap
from pathlib import Path

import fitz


PACK_DIR = Path(__file__).resolve().parents[1]
OUT_DIR = PACK_DIR / "out"
OUTPUT = OUT_DIR / "Solo_AI_Company_OS_Hackathon_Study_Pack_ZH.pdf"

SOURCE_FILES = [
    PACK_DIR / "PRINTABLE_CORE_MANUAL_ZH.md",
    PACK_DIR / "FIELD_CARDS_ZH.md",
    PACK_DIR / "DRILLS_ZH.md",
    PACK_DIR / "ARCHITECTURE_DEEP_DIVE_ZH.md",
]

FONT_CANDIDATES = [
    Path("C:/Windows/Fonts/msyh.ttc"),
    Path("C:/Windows/Fonts/simhei.ttf"),
    Path("C:/Windows/Fonts/simsun.ttc"),
]


def pick_font() -> Path:
    for font in FONT_CANDIDATES:
        if font.exists():
            return font
    raise FileNotFoundError("No Chinese font found in C:/Windows/Fonts")


def strip_frontmatter(text: str) -> str:
    if text.startswith("---\n"):
        parts = text.split("---", 2)
        if len(parts) == 3:
            return parts[2].lstrip()
    return text


def normalize_markdown_line(line: str) -> tuple[str, str]:
    raw = line.rstrip()
    if raw.startswith("# "):
        return "h1", raw[2:].strip()
    if raw.startswith("## "):
        return "h2", raw[3:].strip()
    if raw.startswith("### "):
        return "h3", raw[4:].strip()
    if raw.startswith("- "):
        return "bullet", raw
    if raw.startswith("|"):
        return "table", raw
    if raw.startswith("```"):
        return "code_fence", raw
    return "body", raw


def clean_inline(text: str) -> str:
    text = re.sub(r"`([^`]+)`", r"\1", text)
    text = re.sub(r"\*\*([^*]+)\*\*", r"\1", text)
    return text


def add_wrapped_text(
    doc: fitz.Document,
    page: fitz.Page,
    y: float,
    text: str,
    fontname: str,
    fontsize: float,
    left: float,
    right: float,
    line_height: float,
    page_height: float,
    page_width: float,
    style: str,
) -> tuple[fitz.Page, float]:
    max_chars = max(18, int((right - left) / (fontsize * 0.55)))
    if style in {"code", "table"}:
        max_chars = max(20, int((right - left) / (fontsize * 0.48)))
    wrapped = textwrap.wrap(text, width=max_chars, replace_whitespace=False) or [""]
    for part in wrapped:
        if y > page_height - 56:
            page = doc.new_page(width=page_width, height=page_height)
            y = 56
        page.insert_text((left, y), part, fontname=fontname, fontsize=fontsize, fill=(0, 0, 0))
        y += line_height
    return page, y


def render_pdf() -> Path:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    font_path = pick_font()
    doc = fitz.open()
    page_width, page_height = fitz.paper_size("a4")
    left, right = 54, page_width - 54
    page = doc.new_page(width=page_width, height=page_height)
    doc.insert_font(fontname="ZH", fontfile=str(font_path))
    y = 56
    in_code = False

    for source in SOURCE_FILES:
        text = strip_frontmatter(source.read_text(encoding="utf-8"))
        for line in text.splitlines():
            kind, content = normalize_markdown_line(line)
            if kind == "code_fence":
                in_code = not in_code
                continue

            if not content:
                y += 8
                continue

            if kind == "h1":
                if y > 90:
                    page = doc.new_page(width=page_width, height=page_height)
                    y = 56
                page, y = add_wrapped_text(
                    doc, page, y, clean_inline(content), "ZH", 20, left, right, 28, page_height, page_width, "h1"
                )
                y += 10
            elif kind == "h2":
                y += 8
                page, y = add_wrapped_text(
                    doc, page, y, clean_inline(content), "ZH", 15, left, right, 22, page_height, page_width, "h2"
                )
                y += 4
            elif kind == "h3":
                y += 6
                page, y = add_wrapped_text(
                    doc, page, y, clean_inline(content), "ZH", 13, left, right, 20, page_height, page_width, "h3"
                )
            else:
                style = "code" if in_code else ("table" if kind == "table" else "body")
                fontsize = 9 if style in {"code", "table"} else 10.5
                line_height = 14 if style in {"code", "table"} else 16
                prefix = "  " if style == "code" else ""
                page, y = add_wrapped_text(
                    doc,
                    page,
                    y,
                    prefix + clean_inline(content),
                    "ZH",
                    fontsize,
                    left,
                    right,
                    line_height,
                    page_height,
                    page_width,
                    style,
                )

        page = doc.new_page(width=page_width, height=page_height)
        y = 56

    if len(doc) and not doc[-1].get_text().strip():
        doc.delete_page(len(doc) - 1)

    for index, page in enumerate(doc, start=1):
        footer = f"Solo AI Company OS Study Pack | {index}/{len(doc)}"
        page.insert_text((left, page_height - 28), footer, fontname="ZH", fontsize=8, fill=(0.35, 0.35, 0.35))

    doc.save(OUTPUT)
    doc.close()
    return OUTPUT


if __name__ == "__main__":
    path = render_pdf()
    print(path)

