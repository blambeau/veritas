require File.expand_path('../commons', __FILE__)
files = Dir[File.expand_path('../access.log.*', __FILE__)]

LOGS  = Veritas::Physical::Logs.new(files, [:apache, :combined])
VALID = (relation (heading :http_status => Integer), 
                  (tuple   :http_status => 200    ))

q = (summarize :path,
      (matching \
        (not_matching LOGS,
          (project :user_agent,
            (restrict LOGS, ->(t){ t[:path].match(/robots.txt/) }))),
         VALID),
       Hash[:hits => (count '*'), :weight => (sum :bytes_sent)])
(debug q)
