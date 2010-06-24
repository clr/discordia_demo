class HysteriaEngine

  def self.compute(personality = nil, prior_state = nil, current_events = {})
    current_state = prior_state || {'Attack' => [0,0]}
    current_state.each do |key, behavior|
      behavior[0] = behavior[0] * behavior[1]
    end
    if current_events[:hit]
      current_state['Attack'] = [1.0, 0.9]
    end
    self.save_state(current_state)
    return current_state
  end

  def self.save_state(state)
    File.open(File.join(RAILS_ROOT, 'state', 'one'), 'wb'){|f| Marshal.dump(state, f)}
  end

  def self.load_state
    return nil unless File.exist?(File.join(RAILS_ROOT, 'state', 'one'))
    return File.open(File.join(RAILS_ROOT, 'state', 'one'), 'rb'){|f| Marshal.load(f)}
  end

end
