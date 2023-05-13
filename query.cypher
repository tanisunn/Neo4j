////////////////////////////////////////////////////////////
// ================ Querying For Nodes ================== //
////////////////////////////////////////////////////////////

// Tất cả nút //
MATCH (n) RETURN n

// Tất cả nút với lable cụ thể //
MATCH (player:PLAYER) RETURN player

// Properies cụ thể //
MATCH (player:PLAYER) RETURN player.name, player.height

////////////////////////////////////////////////////////////
// =============== Filtering For Nodes ================== //
////////////////////////////////////////////////////////////

// Nodes với name là LeBron James cách 1 //
MATCH (player:PLAYER) 
WHERE player.name = "LeBron James"
RETURN player

// Nodes với name là LeBron James cách 2 //
MATCH (player:PLAYER {name: "LeBron James"}) 
RETURN player

// Nodes với height >= 2
MATCH (player:PLAYER) 
WHERE player.height >= 2
RETURN player

// Nodes với BMI không lớn hơn 25
MATCH (player:PLAYER) 
WHERE NOT (player.weight / (player.height * player.height)) > 25
RETURN player

// Nodes với height >= 2.1 hoặc weight >= 120
MATCH (player:PLAYER) 
WHERE player.weight >= 120 OR player.height >= 2.1
RETURN player

// Giới hạn trả về - Limit
MATCH (player:PLAYER) 
WHERE player.height >= 2
RETURN player
LIMIT 3

// Bỏ qua - Skip
MATCH (player:PLAYER) 
WHERE player.height >= 2
RETURN player
SKIP 1
LIMIT 3

// Hiển thị giảm dần
MATCH (player:PLAYER) 
WHERE player.height >= 2
RETURN player
ORDER BY player.height DESC
SKIP 1
LIMIT 3

// Truy vấn nhiều  nodes
MATCH (coach:COACH), (player:PLAYER)
RETURN coach, player

////////////////////////////////////////////////////////////
// ============== Querying Relationships ================ //
////////////////////////////////////////////////////////////

// Trả về tất cả players của team LAKER //
MATCH (player:PLAYER) - [:PLAYS_FOR] -> (team:TEAM)
WHERE team.name = "LA Lakers"
RETURN player, team 

// Trả về tất cả players của team LAKER hoặc MAVERICKS //
MATCH (player:PLAYER) - [:PLAYS_FOR] -> (team:TEAM)
WHERE team.name = "LA Lakers" OR team.name = team.name = "Dallas Mavericks"
RETURN player, team 

// Trả về tất cả players của team có lương từ 35M trở lên //
MATCH (player:PLAYER) - [contract :PLAYS_FOR] -> (team:TEAM)
WHERE contract.salary >= 35000000
RETURN player

// Trả về tất cả teammates của LEBRONS có lương từ 40M trở lên //
MATCH (lebron:PLAYER {name: "LeBron James"}) - [:TEAMMATES] -> (teammate:PLAYER)
MATCH (teammate) - [contract:PLAYS_FOR] -> (:TEAM)
WHERE contract.salary >= 40000000
RETURN teammate

////////////////////////////////////////////////////////////
// ==================== Aggregates ====================== //
////////////////////////////////////////////////////////////

// Trả về tất cả players và số lượng trận đấu tham gia //
MATCH (player:PLAYER) - [gamePlayed:PLAYED_AGAINST] - (team:TEAM)
RETURN player.name, COUNT(gamePlayed)

//  Trả về tất cả players và trung bình điểm  trận đấu tham gia //
MATCH (player:PLAYER) - [gamePlayed:PLAYED_AGAINST] - (team:TEAM)
RETURN player.name, AVG(gamePlayed.points)

// Trả về player có điểm TB cao nhất của  LAKERS //
MATCH (player:PLAYER) - [:PLAYS_FOR] - (:TEAM {name: "LA Lakers"})
MATCH (player) - [gamePlayed:PLAYED_AGAINST] - (:TEAM)
RETURN player.name, AVG(gamePlayed.points) AS ppg
ORDER BY ppg DESC
LIMIT 1
