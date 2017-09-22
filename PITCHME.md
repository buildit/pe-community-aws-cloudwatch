
#### AWS CloudWatch Overview

---

#### What We'll Cover
 - CloudWatch Logs
 - CloudWatch Metrics
 - CloudWatch Alarms
 - CloudWatch Dashboards

CloudWatch Events is for another day!
 
---

#### What is CloudWatch?

CloudWatch (CW) is Amazon's centralized logging, monitoring and log analysis solution.  
You can compare with:

 - Logstash
 - Graylog
 - ElasticStack/Elk
 - Splunk
 
(Yeah, these aren't apples-to-apples, but you get the idea.  I'm not a logging heavy.)
 
---

#### Best Thing About CW

It's centralized logging as a service (CLaaS?).  No instances to manage, no agents to configure.  Game over.

OK, well, game not quite over.  You do have to install the CLI, an agent or two, and configure.

But it's vastly simplified over user-managed service/agent-based solutions.

---

#### Main Takeaways
 - You don't have to be "in AWS" to use CW Logs
 - You can watch _any_ log file
 - You can _easily_ publish arbitrary log data (metrics) with simple API calls
 - You can alert on any metric you can publish
 - You can graph any metric you can publish

---

#### Demo
 - Vagrant-based (demonstrates basic provisioning, and that CW can run anywhere)
 - Watching syslog, auth log, a silly "sine" log
 - Script to post silly "sine" data to a custom metric
 - A look at a CW Dashboard created for this chat
 

