##########################################################################
# PowerShell Lab 1
#
# Creating and managing background jobs
# The Jobs randomly selectes the number of seconds (3s-15s) to run. 
# When job is complete it will print the number of seconds it ran.
# 
# Demostrates creating, managing and cleaning up multiple background jobs
###########################################################################

Write-Host "Start multiple jobs in parallel" -ForegroundColor Cyan

# Creating multiple (3) jobs

# '1..3' = array of 3 numbers - range operator
# '$_' = each number passded into a loop
# piping range into a loop
1..3 | ForEach-Object {  
    $jobName = "Job$_"
    Start-Job -Name $jobName -ScriptBlock{ # create job method
        param($jn)   # bind job name here

        $start = Get-Date
        $seconds = Get-Random -Minimum 3 -Maximum 15
        Start-Sleep -Seconds $seconds
        $end = Get-Date
        $duration = ($end - $start).TotalSeconds

        #Output
        [PSCustomObject]@{
            JobName = $jn
            Duration = [math]::Round($duration,2)
            Started = $start
            Finished = $end
        }

    } -ArgumentList $jobName
}
# View created jobs
Write-Host "All jobs started. Let's check them..." -ForegroundColor Green
Get-Job

Write-Host "Wait for all jobs to finish..." -ForegroundColor Cyan
Wait-Job *

# View results per job
Write-Host "Collect results from all jobs" -ForegroundColor Cyan
Get-Job | Receive-Job

Write-Host "Lets clean up jobs..." -ForegroundColor Yellow
Get-Job | Remove-Job

Write-Host "LAB COMPLETED!!! " -ForegroundColor Red