function Get-TweetsSince($query, $since_id=$null) {
  $url = "http://search.twitter.com/search.atom?q=$query&since_id=$since_id"
  $r = [System.Net.WebRequest]::Create($url)
  $response = [System.Net.HttpWebResponse]$r.GetResponse()
  $stream = $response.GetResponseStream()
  $reader = new-object System.IO.StreamReader($stream)
  [xml]($reader.ReadToEnd())
}

function Speak-Text($text) {
  write-host "speaking $text"
  $spk = new-object System.Speech.Synthesis.SpeechSynthesizer
  $spk.Speak($text)
}

add-type -assemblyname system.speech

$tweets = Get-TweetsSince('%23burningriverdevs')
$titles = $tweets.feed.entry | select-object title | %{ Speak-Text $_.title }
