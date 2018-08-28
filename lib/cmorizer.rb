module CMORizer
  class DSLReader
    def initialize(src_txt)
      instance_eval(src_txt, src_txt)
    end
  
  
    def cmorize(*args, &block)
      hash = args.first
      src = hash.keys.first
      results = hash.values.first
      results.each {|r| p CMORizeTask.new(src, r)}
    end


    private
    def method_missing(method_sym, *args, &block)
      method_sym.to_s
    end


    def self.const_missing(name)
      name.to_s
    end
  end


  class CMORizeTask
    def initialize(src, result)
      @src = src
      @result = result
    end
  end
end


if __FILE__ == $PROGRAM_NAME
  src_txt = <<~'EOFHEREDOC'
  # "fesom name"_"available frequency" => ["variable_id"_"CMIP table_id"]
  cmorize tos_day => [tos_Oday, tos_Omon, tos_Odec]
  cmorize tso_3hrPt => [tos_3hr]
  EOFHEREDOC
  
  r = CMORizer::DSLReader.new src_txt
end
