# frozen_string_literal: true
#
# Cookbook Name:: icinga2
# Recipe:: server_object_timeperiod
#
# Copyright 2014, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

icinga2_timeperiod '24x7' do
  display_name 'Icinga 2 24x7 TimePeriod'
  ranges 'monday' => '00:00-24:00',
         'tuesday' => '00:00-24:00',
         'wednesday' => '00:00-24:00',
         'thursday' => '00:00-24:00',
         'friday' => '00:00-24:00',
         'saturday' => '00:00-24:00',
         'sunday' => '00:00-24:00'
  zone node['icinga2']['server']['object']['global-templates'] ? 'global-templates' : nil
end

icinga2_timeperiod '9to5' do
  display_name 'Icinga 2 9to5 TimePeriod'
  ranges 'monday' => '09:00-17:00',
         'tuesday'   => '09:00-17:00',
         'wednesday' => '09:00-17:00',
         'thursday'  => '09:00-17:00',
         'friday' => '09:00-17:00'
  zone node['icinga2']['server']['object']['global-templates'] ? 'global-templates' : nil
end

icinga2_timeperiod 'never' do
  display_name 'Icinga 2 never TimePeriod'
  zone node['icinga2']['server']['object']['global-templates'] ? 'global-templates' : nil
end
