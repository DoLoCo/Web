every :day, at: '3:00am', roles: [:app] do
  rake 'donations:payout'
end