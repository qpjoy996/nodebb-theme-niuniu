
<div class="clearfix post-header">
  <div class="icon pull-left">
    <a
      href="<!-- IF posts.user.userslug -->{config.relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->">
      {buildAvatarMock(posts.user, "sm2x", true, "", "user/picture")}
      <i component="user/status" class="fa fa-circle status {posts.user.status}"
        title="[[global:{posts.user.status}]]"></i>
    </a>
  </div>

  <small class="pull-left">
    <strong>
      <a href="<!-- IF posts.user.userslug -->{config.relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->"
        itemprop="author" data-username="{posts.user.username}" data-uid="{posts.user.uid}">{posts.user.username}</a>
    </strong>

    <!-- IMPORT partials/topic/badge.tpl -->

    <!-- IF posts.user.banned -->
    <span class="label label-danger">[[user:banned]]</span>
    <!-- ENDIF posts.user.banned -->

    <span class="visible-xs-inline-block visible-sm-inline-block visible-md-inline-block visible-lg-inline-block">
      <a class="permalink" href="{config.relative_path}/post/{posts.pid}"><span class="timeago alkun-time"
          title="{posts.timestampISO}"></span></a>

      <i component="post/edit-indicator"
        class="fa fa-pencil-square<!-- IF privileges.posts:history --> pointer<!-- END --> edit-icon <!-- IF !posts.editor.username -->hidden<!-- ENDIF !posts.editor.username -->"></i>

      <small data-editor="{posts.editor.userslug}" component="post/editor" class="hidden">[[global:last_edited_by,
        {posts.editor.username}]] <span class="timeago" title="{posts.editedISO}"></span></small>

      <!-- IF posts.toPid -->
      <a component="post/parent" class="btn btn-xs btn-default hidden-xs" data-topid="{posts.toPid}"
        href="{config.relative_path}/post/{posts.toPid}"><i class="fa fa-reply"></i> @
        <!-- IF posts.parent.username -->{posts.parent.username}
        <!-- ELSE -->[[global:guest]]
        <!-- ENDIF posts.parent.username --></a>
      <!-- ENDIF posts.toPid -->

      <span>
        <!-- IF posts.user.custom_profile_info.length -->
        &#124;
        {{{each posts.user.custom_profile_info}}}
        {posts.user.custom_profile_info.content}
        {{{end}}}
        <!-- ENDIF posts.user.custom_profile_info.length -->
      </span>
    </span>
    <span class="bookmarked"><i class="fa fa-bookmark-o"></i></span>

  </small>
</div>

<br />

<div class="content" component="post/content" itemprop="text">
  {posts.content}
</div>

<div class="alkun-container">
  <div class="alkun-views alkun-item">
    <span>[[global:views]]</span>
    <span class="alkun-item-count human-readable-number" title="{viewcount}">{viewcount}</span>
  </div>
  <div class="alkun-item alkun-topic-reply-btn">
    <a 
      class="alkun-btn"
      href="{config.relative_path}/compose?tid={tid}&title={title}"
      component="topic/reply"
      data-ajaxify="false"
    >
      <i class="fa fa-commenting-o fa-2x"></i>
      <span component="topic/post-count" class="alkun-item-count human-readable-number" title="{postcount}">{postcount}</span>
    </a>
  </div>
  <div class="alkun-item alkun-post-reply-btn">
    <a
      component="post/reply"
      href="#"
      class="alkun-btn no-select < IF !privileges.topics:reply hidden--><!-- ENDIF !privileges.topics:reply >"
    >
      <i class="fa fa-commenting-o fa-2x"></i>
      <!-- <span class="alkun-item-count human-readable-number" title="{posts.replies.count}">{posts.replies.count}</span> -->
      <span class="alkun-item-count replies-count" component="post/reply-count/text" data-replies="{posts.replies.count}">{posts.replies.count}</span>
    </a>
  </div>
  <div class="alkun-item">
    <a component="post/upvote" href="#" class="alkun-btn <!-- IF posts.upvoted -->upvoted<!-- ENDIF posts.upvoted -->">
        <i class="fa fa-thumbs-up fa-2x"></i>
        <i class="fa fa-thumbs-o-up fa-2x"></i>
      <!-- <span class="alkun-item-count" component="post/vote-count" data-votes="{posts.votes}">{posts.votes}</span> -->
    </a> 
  </div>
  <div class="alkun-item">
      <span class="alkun-item-count" component="post/vote-count" data-votes="{posts.votes}">{posts.votes}</span>
  </div>
  <div class="alkun-item">
    <a component="post/downvote" href="#" class="alkun-btn <!-- IF posts.downvoted -->downvoted<!-- ENDIF posts.downvoted -->">
        <i class="fa fa-thumbs-down fa-2x"></i>
        <i class="fa fa-thumbs-o-down fa-2x"></i>
      </a> 
  </div>
  <!-- IMPORT partials/topic/post-menu.tpl -->
</div>

<div class="clearfix post-footer">
  <!-- IF posts.user.signature -->
  <div component="post/signature" data-uid="{posts.user.uid}" class="post-signature">{posts.user.signature}</div>
  <!-- ENDIF posts.user.signature -->

  <small class="pull-right alkun-pullright" style="display: none;">
    <span class="post-tools">
      <a component="post/reply" href="#"
        class="no-select < IF !privileges.topics:reply hidden--><!-- ENDIF !privileges.topics:reply >">[[topic:reply]]</a>
      <a component="post/quote" href="#"
        class="no-select <!-- IF !privileges.topics:reply -->hidden<!-- ENDIF !privileges.topics:reply -->">[[topic:quote]]</a>
    </span>
    
  </small>

  <!-- IF !hideReplies -->
  <a component="post/reply-count" href="#"
    class="threaded-replies no-select <!-- IF !posts.replies.count -->hidden<!-- ENDIF !posts.replies.count -->">
    <span component="post/reply-count/avatars"
      class="avatars <!-- IF posts.replies.hasMore -->hasMore<!-- ENDIF posts.replies.hasMore -->">
      {{{each posts.replies.users}}}
      {buildAvatarMock(posts.replies.users, "xs", true, "")}
      {{{end}}}
    </span>

    <span class="replies-count" component="post/reply-count/text"
      data-replies="{posts.replies.count}">{posts.replies.text}</span>
    <span class="replies-last hidden-xs">[[topic:last_reply_time]] <span class="timeago"
        title="{posts.replies.timestampISO}"></span></span>

    <i class="fa fa-fw fa-chevron-right" component="post/replies/open"></i>
    <i class="fa fa-fw fa-chevron-down hidden" component="post/replies/close"></i>
    <i class="fa fa-fw fa-spin fa-spinner hidden" component="post/replies/loading"></i>
  </a>
  <!-- ENDIF !hideReplies -->
</div>
