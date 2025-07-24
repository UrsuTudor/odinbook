# Odinbook

This is one of my earlier projects, a full stack Ruby on Rails Social Feed app. 

## Features

This app supports several key features:

- Devise Authentication
- Making Posts
- Liking Posts
- Commenting on Posts
- Following Users 

See details below.


## Devise Authentication

- Users can sign up, log in, and manage their sessions securely via Devise.
- Custom parameters (`name`, `city`, `age`) are permitted during registration.
- Devise views have been minimally styled to match the app’s overall color scheme and design.

## Making Posts

Users can create posts with a title and body. The main feed displays posts from the user and from users they follow.

### How it works

- Clicking the **"Make a Post"** button renders the post form inside a `turbo_frame` on the index view.
- Each post:
  - Belongs to a user.
  - Requires a **title** (max 300 characters) and **body** (max 40,000 characters).
- Upon creation, the new post is **prepended** to the `#posts` container using a **Turbo Stream** response, appearing at the top of the feed.
- The visual structure and markup of a post are defined in the `_post.html.erb` partial.

## Liking Posts

Users can **like** or **unlike** posts. The interface dynamically updates based on the user's interaction.

### How it works:

- **Rendering the button:**
  - If the user **has not liked** the post:
    - The app renders a **Like** button using the `likes/form` partial.
    - A new `Like` object is passed as a local variable.
  - If the user **has already liked** the post:
    - The app renders an **Unlike** button using the `likes/unlike_form` partial.
    - The existing `Like` object is passed as a local variable.

- **User interaction:**
  - Clicking **Like** triggers the `LikesController#create` action, with each Like having an associated User and Post.
  - Clicking **Unlike** triggers the `LikesController#destroy` action.

- **After action succeeds:**
  - The server responds with a **Turbo Stream** that:
    - Replaces the button with the opposite state (Like ↔ Unlike).
    - Updates the post's like count in real-time without page reload.
  
## Commenting on Posts

Users can comment on posts made by other users.

### How it works

- Each post renders its associated comments directly beneath it.
- Comments have an associated Post and User and must include a body, validated with a **maximum length of 8000 characters**.
- When a user submits a comment:
  - The `CommentsController#create` action returns a **Turbo Stream** response.
  - This response uses `create.turbo_stream.erb` to append the new comment to the correct post.
- The layout and styling of each comment are defined in the `_comment.html.erb` partial.

## Following Users

Users can send, accept, reject, and cancel follow requests, as well as unfollow other users.

### How it works

- A **follow request** button is rendered using the `follow_request_form` helper next to a user's link or above their avatar on their profile page.
  - This only appears if the current user has not already sent or been rejected for a follow request.
- When a follow request is submitted:
  - The `FollowRequestsController#create` action creates a `FollowRequest` object, storing the sender and recipient IDs.
  - New requests are initialized with a `"pending"` status.
- Incoming `"pending"` requests are displayed at the top of the feed using the `follow_request_decision_form` helper.
- Users can **accept** or **reject** requests via the `UsersController` methods: `accept_follow_request` and `reject_follow_request`.
  - Accepting creates a mutual association and sets the request's status to `"accepted"`.
  - Rejecting removes the pending request and sets the status to `"rejected"`.
- Users can also **unfollow** others at any time by clicking the `Unfollow` button, rendered with the `unfollow_button` helper.
