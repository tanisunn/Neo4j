// Cập nhật giá trị properties của Node
MATCH (n) 
WHERE ID(n) = 10
SET n.height = 2.08
RETURN n

// Cập nhật lable mới
MATCH (lebron)
WHERE ID(n) = 3
SET lebron:REF
RETURN lebron

// Cập nhật giá trị properties của Relationship
MATCH (lebron {name: "LeBron James"}) - [contract:PLAYS_FOR] -> (:TEAM)
SET contract.salary = 60000000

// Xóa Lable
MATCH (n)
WHERE ID(n) = 10
REMOVE n:REF
RETURN 

// Xóa giá trị properties của Node
MATCH (n)
WHERE ID(n) = 10
REMOVE n.height
RETURN n
