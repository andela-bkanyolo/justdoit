class ApiConstraints
  attr_reader :version

  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(request)
    @default || request.headers["Accept"].include?(
      "application/vnd.justdoit.v#{@version}+json"
    )
  end
end
