require 'game'

module Parser
  #This module is responsable for parsing
  # the game file
  OPTIONS = {
    :stack_references => false
  }


  def
end

module GameParser

  def cmd
    print "> "
    line = gets
    line.split("\n")
  end

  def read str
    if str == ""
      # você não fez nada
    elsif str =~ /[vá|indo|vou] para \w*/
      # indo pra algum lugar
    elsif str == "inventário"
      # o que há no inventário ?
    elsif str == "fim"
      #fim do jogo
    # elsif 
    end
  end

  def answer
    
  end

end