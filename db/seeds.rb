# frozen_string_literal: true

# User data
User.create(user_name: 'Ahmad Hassan', email: 'a2h.ahmadhassan@gmail.com', password: '12345678',
            password_confirmation: '12345678', role: 2)
User.create(user_name: 'M Sallah', email: 'hassana2hwwe@gmail.com', password: '12345678',
            password_confirmation: '12345678')
User.create(user_name: 'Ahmad Adnan', email: 'hassana2hx@gmail.com', password: '12345678',
            password_confirmation: '12345678')
User.create(user_name: 'Haseeb Mustafa', email: 'ahmad.naeemllah@devsinc.com', password: '12345678',
            password_confirmation: '12345678', role: 1)

# Seeds of posts
Post.create(title: 'Hello World', body: 'Dummy body text ... lorem ipsem', user_id: 2, status: 10)
Post.create(title: 'Hello World', body: 'Dummy body text ... lorem ipsem', user_id: 2, status: 10)
Post.create(title: 'Hello World', body: 'Dummy body text ... lorem ipsem', user_id: 2, status: 10)
Post.create(title: 'Hello World', body: 'Dummy body text ... lorem ipsem', user_id: 2, status: 10)
Post.create(title: 'Hello World', body: 'Dummy body text ... lorem ipsem', user_id: 2, status: 10)
Post.create(title: 'Hello World', body: 'Dummy body text ... lorem ipsem', user_id: 2, status: 10)
Post.create(title: 'Hello World', body: 'Dummy body text ... lorem ipsem', user_id: 2, status: 10)
Post.create(title: 'Hello World', body: 'Dummy body text ... lorem ipsem', user_id: 2, status: 10)
Post.create(title: 'Hello World', body: 'Dummy body text ... lorem ipsem', user_id: 2, status: 10)
Post.create(title: 'Hello World', body: 'Dummy body text ... lorem ipsem', user_id: 2, status: 10)
Post.create(title: 'Hello World', body: 'Dummy body text ... lorem ipsem', user_id: 2, status: 10)
Post.create(title: 'Hello World', body: 'Dummy body text ... lorem ipsem', user_id: 2, status: 10)
Post.create(title: 'Hello World', body: 'Dummy body text ... lorem ipsem', user_id: 2, status: 10)

Comment.create(body: 'Hello World', user_id: 2, post_id: 3)
Comment.create(body: 'Hello World', user_id: 2, post_id: 3)
Comment.create(body: 'Hello World', user_id: 2, post_id: 3)
Comment.create(body: 'Hello World', user_id: 2, post_id: 4)
Comment.create(body: 'Hello World', user_id: 2, post_id: 4)

Suggestion.create(body: 'Thanks for this article, maybe improve spelling next time', user_id: 4, post_id: 51)
Suggestion.create(body: 'Thanks for this aticle, maybe improve spelling next time', user_id: 4, post_id: 51)
Suggestion.create(body: 'Thaks for this article, maybe improve spelling next time', user_id: 4, post_id: 51)
Suggestion.create(body: 'Thanks or this article, maybe improve spelling next time', user_id: 4, post_id: 51)
