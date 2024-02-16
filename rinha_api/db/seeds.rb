# client_id, limit, balance
clients_data = [
  [1, 100_000,	0],
  [2,	80_000,	0],
  [3,	1_000_000,	0],
  [4,	10_000_000,	0],
  [5,	500_000,	0]
]

clients_data.each do |client_id, limit, balance|
  Account.create!(client_id: client_id, limit: limit, balance: balance)
end
