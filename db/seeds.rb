# frozen_string_literal: true

puts "Loading seeds..."

user = FactoryBot.create(:user)
andy = FactoryBot.create(:user, name: "Andreas Finger", email: "andy@mediafinger.com")

FactoryBot.create(:question, title: "Why do you like", body: "Working at Cookpad?", user: user)

cv = <<~CURRICULUMVITAE
  # Señor Developer

  ## About me(_diafinger_)

  Born and raised in a small town in the west of Germany, I moved to Hamburg to study Media Information Science (Medieninformatik) at the FH Wedel. With my previous experience of building simple websites, I was able to land jobs as a student programmer at AOL and smaller companies.

  After a year long break in which I studied in Bristol (UK) and lived and traveled in and around Vancouver (Canada), I returned to Hamburg to finish my Diploma (closer to the Master than the Bachelor degree) and start my career. I stayed there until the end of 2012 when I moved to Barcelona (Spain), a great place to enjoy life.

  During my professional career I worked for agencies, a browser games company, an internet translation company <https://tolingo.com>, a large social network <https://xing.com>, a web development bootcamp <https://www.ironhack.com>, a bank <https://solaris.bank>, and have been self-employed.

  While my role was usually that of a web developer, I also developed applications, designed and balanced the game mechanics of a football manager and taught and mentored aspiring web developers.

  Previously, I worked with languages like Perl, PHP, Java and ActionScript. But since discovering Ruby in 2010 I have worked exclusively with Ruby - and all the other languages and DSLs that come with Ruby and Ruby on Rails applications.

  I like Ruby so much that I started teaching it to beginners. First through RailsGirls workshops in Hamburg and Barcelona (where I also organized both). Later through periodical meetups in Barcelona and as a (paid) teacher and mentor in the Ironhack Web Development Bootcamp. I am also one of the organizers of [Barcelona on Rails](https://www.meetup.com/Barcelona-on-Rails), the local Ruby User Group.

  The last 18 months I worked as a freelancer for solarisBank - a newly founded bank and tech company that offers financial products strictly over APIs. The main office is in Berlin, but I worked fully remote from Barcelona.

  > At the moment I'm working on a 2 months project and will be available from end of July again.


  ## In case you want to hire me

  I enjoy working in small companies with small development teams. This setup promises light processes and demands independent workers. People have to show initiative and should be willing and able to make decisions. At the same time it enables transparency and clear communication structures.

  I do consider myself to be a product developer thinking of all parts of an implementation and not only 'my code'. I prefer to write simple, maintainable code and to find a good, pragmatic solution, instead of a complex one. When layers of abstractions or optimizations become necessary, they can be added at the right moment.

  I am a strong communicator. Spreading information and connecting people comes natural to me. I do push my colleagues to share more. Be it through the group chat or in pull request descriptions or by creating new tickets. When I am in the office, I use the opportunity to connect with people outside of my team to learn more about the business in general. When I am remote, video chats help discussing complex matters.

  I am happy to work in a fully remote position. At home in Barcelona I have a great setup with standing desk, 4k screen, 200 MBit fibre connection and a sunny balcony. Now that summer is approaching I want to take advantage of living in Spain with a ‘Bulli’ and work [besides a beach](https://raw.githubusercontent.com/mediafinger/mediafinger.github.io/master/bulli_beach.jpg title="Playa de las Hurnas, Spain") or [in the mountains](https://raw.githubusercontent.com/mediafinger/mediafinger.github.io/master/bulli_montsec.jpg title="Montsec, Spain") from time to time - when there is a fast internet connection available.

  > Feel free to offer me _competitively compensated_ **remote** roles. I am registered as an autónomo (freelancer) in Spain.


  ## Most challenging development projects

  ### 2012 at tolingo: integrating Salesforce CRM
    - replacing old PHP monolith
    - new customer facing Rails app
    - new operators facing Rails app
    - implementing a new payment solution
    - integrating Salesforce
    - Ruby services to glue internal and external apps together
    - challenging because of: the complexity of the task, developing new apps, integrating a large external application, big bang release (not the idea of the dev team)

  ### 2013 at XING: messages (over 1 billion existing threads)
    - modeling the data structure
    - optimizing queries for speed
    - migrating from old Perl to new Ruby implementation without affecting the users
    - challenging because of: the sheer amount of data, the sensitivity of the data, the search results' speed and quality

  ### 2014 at XING: XTM statistics
    - collecting usage data
    - accumulating existing data
    - creating a data structure optimized for query speed
    - displaying statistics to different user roles through a flexible interface
    - challenging because of: development of the whole feature, finding a maintainable and fast solution without increasing the technical complexity of the whole project

  ### 2017 at solarisBank: Business Identifications
    - extracting existing functionality out of a monolith while building a dockerized m/SOA architecture
    - adding new functionality in new services
    - connecting to a terrible XML (non SOAP) API (without good documentation)
    - following banking and data privacy regulations closely
    - challenging because of: constantly changing architecture, unstable API, time pressure to be the first on the market with a solution to identify businesses and their legal representatives in an online process

  ## Links
    - Twitter: [@mediafinger](https://twitter.com/mediafinger)
    - LinkedIn: <https://www.linkedin.com/in/andreasfinger>
    - XING: <https://www.xing.com/profile/Andreas_Finger>
    - Github: [mediafinger](https://github.com/mediafinger)

CURRICULUMVITAE

code = <<~CODE
  By default, pg_search ranks results based on the `:tsearch` similarity between
  the searchable text and the query. To use a different ranking algorithm, you
  can pass a `:ranked_by` option to pg_search_scope.

  ```ruby
  class Image < ApplicationRecord
    include PgSearch::Model

    pg_search_scope :search_by_tsearch_but_rank_by_trigram,
                    :against => :title,
                    :using => [:tsearch],
                    :ranked_by => ":trigram"
  ```

  Note that `:ranked_by` using a String to represent the ranking expression. This
  allows for more complex possibilities. Strings like `":tsearch"`, `":trigram"`,
  and `":dmetaphone"` are automatically expanded into the appropriate SQL
  expressions.

  ```ruby
  # Weighted ranking to balance multiple approaches
  :ranked_by => ":dmetaphone + (0.25 * :trigram)"

  # A more complex example, where books.num_pages is an integer column in the table itself
  :ranked_by => "(books.num_pages * :trigram) + (:tsearch / 2.0)"
  ```
CODE

FactoryBot.create(:question, title: "Code syntax highlighting", body: code, user: user)
q3 = FactoryBot.create(:question, user: andy, title: "Do you want to read my CV?", body: cv)
q2 = FactoryBot.create(:question, :markdown, user: andy)
FactoryBot.create(:question, user: andy)

Answer.create!(question: q2, user: user, title: "Don't worry!", body: "Your **markdown** looks just _fine_!")
Answer.create!(question: q2, user: andy, title: "Thank you", body: "👍🏼👍🏼👍🏼")
Answer.create!(question: q3, user: andy, title: "In case you are wondering",
               body: "This is the same that is accessible under http://mediafinger.com 😊 \n\n > where it's rendered nicer")
