Open Data Platform
==================

The goal of this project is to make it easy for corporations to publish raw
data related to the external impact of their operations, allowing researchers,
students and third party application developers to analyze and present the
information in useful ways.

Progressive corporations often dedicate significant resources to annual
reports describing the impact of their operations with respect to the environment.
They do so because they want to make a statement regarding the efforts they
are making to serve customer needs in a sustainable way. However, by packaging
these data in a glossy, human readable brochure, they are missing out on a
wonderful opportunity.

Publishing the raw data online will allow researchers and other interested
parties to analyze, compare, and present it in useful ways, beyond the scope
of any company's CSR department.

Seventh Generation is the first company to use this platform (online at
http://opendata.seventhgeneration.com). Other companies are strongly encouraged
to do the same by forking this project, customizing it to their needs, and
publishing their own datasets.

The power of the platform grows with each new participant. Join us by unlocking
your data!

Participants
============

- Seventh Generation: http://opendata.seventhgeneration.com
- You? Fork the project and get your data out there!

Partners
========

- Seventh Generation: http://www.seventhgeneration.com
- CERES: http://www.ceres.org


How To Get Started
==================

- Fork this project
- Customize the CSS to add your company branding
- Sign up for Heroku and Amazon S3
- Copy config/heroku_env.rb.template to config/heroku_env.rb and update accordingly
- Add config variables to Heroku env with heroku config:add
- Push to Heroku
- Create admin account with console: heroku console, then Admin.create(:email => 'youremail', :password => 'yourpassword')
- Customize site settings
- Customize Devise settings
- Customize config.action_mailer.default_url_options in environments/production.rb
- Publish your data


Thanks
======

This application makes use of the following open source code/assets/plugins/gems/engines.
Many thanks to these fine contributors to the open source community!

- Warden 0.10.7: http://wiki.github.com/hassox/warden
- Devise 1.0.8: http://github.com/plataformatec/devise/tree/v1.0
- Formtastic 1.0.1: http://github.com/justinfrench/formtastic
- Paperclip 2.3.3: http://github.com/thoughtbot/paperclip
- FAMFAMFAM Silk 1.3: http://famfamfam.com/lab/icons/silk/
- IconDock social media icons: http://icondock.com/free/vector-social-media-icons
- validates_timeliness 2.2.2: http://github.com/adzap/validates_timeliness/
- acts_as_taggable_on 2.0.6: http://github.com/mbleigh/acts-as-taggable-on
- mail_form 1.0.0: http://github.com/plataformatec/mail_form/tree/v1.0
- jQuery 1.4.2: http://jquery.com/
- AutoSuggest jQuery plugin: http://code.drewwilson.com/entry/autosuggest-jquery-plugin


License
=======

All code and design assets are made available under the MIT License.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
