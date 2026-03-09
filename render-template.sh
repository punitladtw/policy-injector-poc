#!/bin/bash
set -e

FINDINGS=$(aws accessanalyzer validate-policy --policy-document file://policy.json --policy-type RESOURCE_POLICY)
FINDINGS_COUNT=$(echo $FINDINGS | jq '.findings | length')

if [[ "$FINDINGS_COUNT" -gt 0 ]]; then
  echo "Found $FINDINGS_COUNT policy issue(s):"
  echo $FINDINGS | jq .
  exit 1
fi

cfn-flip policy.json policy.yaml
rain pkg iam-stack.yaml --output iam-stack-rendered.yaml