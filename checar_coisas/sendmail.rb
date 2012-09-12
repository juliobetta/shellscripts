require 'gmail'

Gmail.new(ARGV[0], ARGV[1]) do |gmail|
  gmail.deliver do
    to ARGV[0] 
    subject ARGV[2]
    html_part do
      content_type 'text/html; charset=UTF-8'
      body (
	    "<p> #{ARGV[2]} ja se encontra disponivel</p>" <<
 	    "<a href='#{ARGV[3]}'>Ir para a página</a>" 
	   )
    end
  end
  gmail.logout 
end

 
