class ChartsController < ApplicationController

  def get
    respond_to do |format|
      format.html{render :action => 'get'}
      format.js do
        @reaction = HysteriaEngine.compute(nil, HysteriaEngine.load_state, params)
        render :json => @reaction
      end
    end
  end

end
