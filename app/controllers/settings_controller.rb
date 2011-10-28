# -*- coding: utf-8 -*-
class SettingsController < ApplicationController
  # GET /settings
  # GET /settings.xml
  def index
    @settings = Setting.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @settings }
    end
  end

  # GET /settings/1
  # GET /settings/1.xml
  def show
    @setting = Setting.find(params[:id])
    pref_id = Station.search_pref(current_user)
    @pref = Setting.prefecture_index_show(pref_id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @setting }
    end
  end

  # GET /settings/new
  # GET /settings/new.xml
  def new
    @setting = current_user.setting || Setting.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setting }
    end
  end

  # GET /settings/1/edit
  def edit
    @setting = current_user.setting
  end

  # POST /settings
  # POST /settings.xml
  def create
    @setting = current_user.build_setting(params[:setting])
    @setting.notice_at = Time.local(2011, 10, 31, @setting.notice_at.hour, @setting.notice_at.min)
    @setting.save
    respond_to do |format|
      format.html { redirect_to(setting_url(@setting))}
      format.xml  { head :ok }
    end
  end

  # PUT /settings/1
  # PUT /settings/1.xml
  def update
    @setting = Setting.find(params[:id])
    @setting.notice_at = Time.local(2011, 10, 31, @setting.notice_at.hour, @setting.notice_at.min)
    @setting.update_attributes(params[:setting])
    respond_to do |format|
      format.html { redirect_to(setting_url(@setting))}
      format.xml  { head :ok }
    end
  end

  def init
  end

  def search
    @params_station = params[:station]
  end
end
