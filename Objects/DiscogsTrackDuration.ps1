class DiscogsTrackDuration {
    [TimeSpan] $TimeSpan
    [string] ToString() {
        $time = ''
        if ($this.TimeSpan.Hours -gt 0) {
            $time = $this.TimeSpan.Hours.ToStirng() + ':' + $this.TimeSpan.Minutes.ToString() + ':' + $this.TimeSpan.Seconds.ToString()
        } else{
            $time = $this.TimeSpan.Minutes.ToString() + ':' + $this.TimeSpan.Seconds.ToString()
        }
        return $time
    }
    DiscogsTrackDuration([string]$strin) {
        $split = $strin.Split(':')
        if ($split.Count -eq 3) {
            $this.TimeSpan = New-TimeSpan -Hours $split[0] -Minutes $split[1] -Seconds $split[2]
        } elseif ($split.Count -eq 2) {
            $this.TimeSpan = New-TimeSpan -Minutes $split[0] -Seconds $split[1]
        }
    }
    DiscogsTrackDuration() {
        #Defualt Empty Constructor
    }
}

#New-Object -TypeName 'DiscogsTrackDuration' -ArgumentList @('11:30')
