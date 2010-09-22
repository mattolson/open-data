class HomeController < ApplicationController
  def index
    @datasets = Dataset.find(:all, :conditions => ["is_featured = ?", true], :limit => 3, :order => 'last_uploaded_at desc')
    @apps = App.find(:all, :conditions => ["is_published = ? and is_featured = ?", true, true], :limit => 3, :order => 'created_at desc')
  end

  def about
  end

  def contact
  end

  def license
  end

  def participants
  end
end
