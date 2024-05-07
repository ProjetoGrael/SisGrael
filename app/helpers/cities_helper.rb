module CitiesHelper
  def state_options
    State.all.collect {|x| [x.name, x.id]}
  end
end
