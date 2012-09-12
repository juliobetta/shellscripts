require 'gmail'

Gmail.new(ARGV[0], ARGV[1]) do |gmail|
  gmail.deliver do
    to ARGV[0] 
    subject 'passagem 1001'
    html_part do
      content_type 'text/html; charset=UTF-8'
      body (
	    "<p>Ja se encontra disponivel os horarios requeridos</p>" <<
 	    "<a href='#{ARGV[2]}'>Link para comprar</a>" 
	   )
    end
  end
  gmail.logout 
end

 
