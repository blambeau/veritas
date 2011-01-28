require File.expand_path('../commons', __FILE__)

# How many hits per page ??
(debug (summarize LOGS, :path, :count => (count '*')))

# What pages have not been found ??
NOT_FOUND = (restrict LOGS, ->(t){ t[:http_status].eq(404) })
(debug (project NOT_FOUND, :path))
    
# How many times each ??
(debug (summarize NOT_FOUND, :path, :count => (count '*')))

# Who are the robots ??
ROBOT_AGENTS = (project (restrict LOGS, ->(t){ t[:user_agent].match(/[Bb]ot/) }), :user_agent)
(debug ROBOT_AGENTS)

# Or should it be requesters of 'robots.txt' ??
ROBOT_REQUESTERS = (project (restrict LOGS, ->(t){ t[:path].match(/robots.txt/) }), :user_agent)
(debug ROBOT_REQUESTERS)

# Which robots are not named 'bot' ??
(debug (minus ROBOT_REQUESTERS, ROBOT_AGENTS))

# What are logs if robots are not taken into account ??
INTERESTING_LOGS = (minus LOGS, (join LOGS, ROBOT_REQUESTERS))

# How many hits per page, not counting robots ??
(debug (summarize INTERESTING_LOGS, :path, 
        :count    => (count '*'), 
        :min_time => (min :timestamp),
        :weight   => (sum :bytes_sent)))

