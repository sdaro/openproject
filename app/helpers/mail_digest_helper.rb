#-- encoding: UTF-8

#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2021 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See docs/COPYRIGHT.rdoc for more details.
#++

module MailDigestHelper
  def digest_timespan_text
    end_time = Time.parse(Setting.notification_email_digest_time)

    I18n.t(:"mail.digests.time_frame",
           start: format_time(end_time - 1.day),
           end: format_time(end_time))
  end

  def digest_notification_timestamp_text(notification, html: true)
    journal = notification.journal
    user = html ? link_to_user(journal.user, only_path: false) : journal.user.name

    raw(I18n.t(:"mail.digests.work_packages.#{journal.initial? ? 'created_at' : 'updated_at'}",
               user: user,
               timestamp: time_ago_in_words(journal.created_at)))
  end

  def unique_reasons_of_notifications(notifications)
    notifications
      .map { |notification| notification.reason_mail_digest }
      .uniq
  end
end
