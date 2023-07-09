#!/bin/sh

manifest_file_path="$1"
output_file_path="$2"

printf "Analysing the stack. Please wait..\n\n"

# Getting stack analysis report using CRDA API.
report=$(crda-javascript-api stack $manifest_file_path)

exit_code=$?

if [ $exit_code == 1 ]
then
  # In case of failure save only exit code into output file.
  jq -n {} | \
  jq --arg exit_code "$exit_code" '. + {exit_code: $exit_code}' > \
  $output_file_path
else
  # In case of success print details from report into console
  printf "RedHat CodeReady Dependency Analysis task is being executed.\n"
  printf "=%.0s" {1..50}
  printf "\nRedHat CodeReady Dependency Analysis Report\n"
  printf "=%.0s" {1..50}
  printf "\n"
  printf "Total Scanned Dependencies            :  %s \n" "$(jq -r '.summary.dependencies.scanned' <<< $report)"
  printf "Total Scanned Transitive Dependencies :  %s \n" "$(jq -r '.summary.dependencies.transitive' <<< $report)"
  printf "Total Vulnerabilities                 :  %s \n" "$(jq -r '.summary.vulnerabilities.total' <<< $report)"
  printf "Direct Vulnerable Dependencies        :  %s \n" "$(jq -r '.summary.vulnerabilities.direct' <<< $report)"

  provider_statuses=$(jq -rc '.summary.providerStatuses[]' <<< $report)
  for provider_status in $provider_statuses; do         
    message=$(echo $provider_status | jq -r '.message')
    provider=$(echo $provider_status | jq -r '.provider')
    printf "%s Provider Status                  :  %s \n" ${provider^} $message
  done

  printf "Critical Vulnerabilities              :  %s \n" "$(jq -r '.summary.vulnerabilities.critical' <<< $report)"
  printf "High Vulnerabilities                  :  %s \n" "$(jq -r '.summary.vulnerabilities.high' <<< $report)"
  printf "Medium Vulnerabilities                :  %s \n" "$(jq -r '.summary.vulnerabilities.medium' <<< $report)"
  printf "Low Vulnerabilities                   :  %s \n" "$(jq -r '.summary.vulnerabilities.low' <<< $report)"
  printf "=%.0s" {1..50}

  # Save report along with exit code into output file.
  jq -n {} | \
  jq --argjson report "$report" '. + {report: $report}' | \
  jq --arg exit_code "$exit_code" '. + {exit_code: $exit_code}' > \
  $output_file_path
fi

printf "\nFull report is saved into file: $output_file_path"
printf "\nTask is completed."