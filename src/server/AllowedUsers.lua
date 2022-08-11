local allowedUsers = {}

--Allow users to use roblosploit based on userid (reccomended) or username (not reccomended)
allowedUsers["ids"] = { 34273581 }
allowedUsers["usernames"] = { "WithinCode" }

--If true, then the owner of the VIP server will be allowed to send commands
allowedUsers["vip"] = false
--If true, completely disables the verification check on VIP servers
allowedUsers["vip-all"] = false

return allowedUsers
