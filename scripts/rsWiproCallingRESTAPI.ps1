[Reflection.Assembly]::LoadWithPartialName("System.Net")

# POSTING AN ACTIVITY

$activity_json = '{ "activity":{
        "actor":{"name":"Govindaraj Rangan","email":"govindaraj.rangan@wipro.com"},
        "action":"create",
        "object": {"url":"someURL","title":"LoB Connect"},
        "message":"Update from Powershell"
        } }';
# GET AUTH TOKEN
# Authorize by going to: https://www.yammer.com/dialog/oauth?client_id=[:client_id]&redirect_uri=[:redirect_uri]
# Yammer replies with auth_code to: [:redirect_uri]?code=[:auth_code]
# Use this auth_code to get auth_token.json which has the auth_token using the following URL
# https://www.yammer.com/oauth2/access_token.json?client_id=[:client_id]&client_secret=[:client_secret]&code=[:auth_code]

$oauth_token = "OAUTH_TOKEN"; #wipro-microsoft

$post_body = [System.Text.Encoding]::ASCII.GetBytes($activity_json); 
$url = "https://www.yammer.com/api/v1/activity.json";
[System.Net.HttpWebRequest] $request = [System.Net.WebRequest]::Create($url);
$request.Method = "POST";
$request.Headers.Add("Authorization", "Bearer " + $oauth_token);
$request.ContentType = "application/json";
$body = $request.GetRequestStream();
$body.write($post_body, 0, $post_body.length);
$body.flush();
$body.close();
$response = $request.GetResponse();