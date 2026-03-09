#!/bin/bash

aws accessanalyzer validate-policy --policy-document file://$1 --policy-type RESOURCE_POLICY

cfn-flip policy.json policy.yaml

rain pkg iam-stack.yaml