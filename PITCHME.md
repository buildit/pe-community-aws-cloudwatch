
#### AWS CloudWatch Overview

---

#### Hey Mike -- `vagrant up`!

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

#### CloudWatch is Ubiquitous

Well, in AWS anyway!

Everywhere you look, CloudWatch logs and metrics are at play.
 
---

#### Best Thing About CW

**It's centralized logging as a service (CLaaS?).**

No instances to manage, no agents to configure.  Game over.

OK, well, game not quite over.  You do have to install the CLI, an agent or two, and configure.

But it's vastly simplified over user-managed service/agent-based solutions.

If it's good enough for Amazon, it's probably good enough for us (?)

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
   - Note that non-EC2 uses require setting up credentials
   - In EC2 you'd use an instance profile (role) with appropriate permissions
 - Use awslogs agent to watch `syslog`, `auth.log`, a silly "sine" log
 - Script to post silly "sine" data to a custom metric
 - Use a metric and alert to notify when a user account is added
 - A look at a CW Dashboard created for this chat
 
