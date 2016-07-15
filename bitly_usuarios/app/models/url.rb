class Url < ActiveRecord::Base
    # Remember to create a migration!

  validates :long_url, :uniqueness => true
  validates :short_url, :uniqueness => true
  validate :valid_url
  # validates_format_of :long_url, :with => URI::regexp(%w(http https))

  def valid_url
    slash = Regexp.escape('//')

    regex = /\Ahttps:#{Regexp.escape('//')}/

    unless long_url =~ /\Ahttps:#{Regexp.escape('//')}/ || long_url =~ /\Ahttp:#{Regexp.escape('//')}/
      errors.add(:long_url, "No ingresaste una URL")
    end
  end

  def self.generate_url
    letras = ('a'..'z').to_a
    numeros = (1..9).to_a
    url = ''

    for i in 1..8
      random_n = rand(0..8)
      random_l = rand(0..25)

      if i >= 1 && i <= 3
        #Tres letras minusculas
        url += letras[random_l]
      elsif i >= 4 && i <= 5
        #Dos numeros
        url += numeros[random_n].to_s
      elsif i >= 6 && i <= 7
        #Dos letras mayusculas
        url += letras[random_l].upcase
      elsif i == 8 
        #Un numero
        url += numeros[random_n].to_s
      end 
    end
    url
  end

  def ini_uri
    'http://sho.di/'
  end
end
