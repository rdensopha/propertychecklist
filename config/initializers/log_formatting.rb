class ActiveSupport::BufferedLogger
  def formatter=(formatter)
    @log.formatter = formatter
  end
end
 
class Formatter
  def call(severity, time, progname, msg)
      formatted_severity = sprintf("%-5s","#{severity}")
      formatted_time = time.strftime("%Y-%m-%d %H:%M:%S.") << time.usec.to_s[0..2].rjust(3)
  
       msg.gsub!(/\\x1B\[.m\s*(\\x1B\[\d+m)*/)
       "-#{formatted_time}-#{formatted_severity}-#{msg}-(pid:#{$$})\n"
  end
end
 
Rails.logger.formatter = Formatter.new