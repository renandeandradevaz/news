class UtilProfile

  def self.salvar_resultado_profile(results)

    File.open "#{Rails.root}/tmp/performance/#{Time.now}-stack.html", 'w' do |file|
      RubyProf::CallStackPrinter.new(results).print(file)
    end

  end
end
