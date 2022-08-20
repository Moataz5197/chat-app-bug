Redis.current = Redis.new(:host => ('redis'),
                          :port => ( 6379 ).to_i,
                          :password => ( 'moataz' ))