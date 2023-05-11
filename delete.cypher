// Xóa Node : cách sai do vướng relationships liên quan
MATCH(ja {name: "Ja Morant"})
DELETE ja

// Xóa node và relationships
MATCH(ja {name: "Ja Morant"})
DETACH DELETE ja

// Xóa relationship
MATCH(joel {name: "Joel Embiid"}) - [rel:PLAYS_FOR] -> (:TEAM)
DELETE rel
