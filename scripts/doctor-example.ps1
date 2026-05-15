param(
  [ValidateSet("handoff-completed", "handoff-active", "handoff-expired", "worklog-dirty", "privacy-rewrite")]
  [string]$Case = "handoff-expired"
)

$examples = @{
  "handoff-completed" = @"
handoff_id: demo_001
status: completed
attempt_id: attempt_001
source_fingerprint: sha256:abc123
"@
  "handoff-active" = @"
handoff_id: demo_002
status: processing
lease_owner: agent_a
lease_expires_at: 2099-01-01T10:00:00
attempt_id: attempt_001
source_fingerprint: sha256:abc123
"@
  "handoff-expired" = @"
handoff_id: demo_003
status: processing
lease_owner: agent_a
lease_expires_at: 2020-01-01T10:00:00
attempt_id: attempt_001
source_fingerprint: sha256:abc123
"@
  "worklog-dirty" = @"
owner: AI-02
findings:
  - response time is much faster
tools_used: []
verification:
evolution_decision: record
"@
  "privacy-rewrite" = @"
I verified this in [PRIVATE_PROJECT_NAME] under [PRIVATE_LOCAL_PATH] with [PRIVATE_CUSTOMER_DATA].
"@
}

Write-Output $examples[$Case]
