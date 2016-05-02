#!/usr/bin/perl -w
#

# Generates data.js for RapidStart Repository
# 

$REPO = "/opt/bitnami/apache2/htdocs/repo/repoData.js";
print "Initiating RapidStart Repository build...\n";

# Read the current repo
open FILE, $REPO or die "Couldn't open file $REPO: $!\n";
$data = <FILE>;
close FILE;

$newEntry = '{name: "AWS Infra Reference CFN template C1 demo",description: "Creates a reference design of all the necessary components to host and run a highly available multi-tier, multi-subnet app in AWS",type: "blueprint",viewUrl: "https://s3.ap-northeast-2.amazonaws.com/cf-templates-1ulj0dbkqewd5-ap-northeast-2/rsAWSAppDeployReferenceModel.template",designerUrl: "https://ap-northeast-2.console.aws.amazon.com/cloudformation/designer/home?templateURL=https://s3.ap-northeast-2.amazonaws.com/cf-templates-1ulj0dbkqewd5-ap-northeast-2/rsAWSAppDeployReferenceModel.template&region=ap-northeast-2",launchUrl: "https://ap-northeast-2.console.aws.amazon.com/cloudformation/home?region=ap-northeast-2#/stacks/new?stackName=TestLaunch1867737172&templateURL=https://s3.ap-northeast-2.amazonaws.com/cf-templates-1ulj0dbkqewd5-ap-northeast-2/rsAWSAppDeployReferenceModel.template",helpUrl: "",icon: "images/default.png",provider: "aws" },';

$data =~ s/\]\;$/$newEntry\]\;/;
print $data;
# Write to the repo
open FILE, "> $REPO" or die "Cannot write to file $REPO: $!\n";
print FILE $data;
close FILE;
