$(function(){
  $('.microposts').on('click', '.like', function(event){
    event.preventDefault();
    var post_id = $(this).parent().attr('id').split('-')[1];
    var that = this;
    $.post('/like/'+post_id, function(data){
        $(that).parent().find('.likes_count').text('Has '+data['likes']+' likes.');
    });
  });

  $('.microposts').on('click', '.delete' ,function(event){
      event.preventDefault();
      var post_id = $(this).parent().attr('id').split('-')[1];
      var that = this;
      var request = $.ajax({
        url: '/microposts/'+post_id,
        type: 'DELETE',
        success: function(data){
          if(data['success'] == post_id){
            $(that).parent().remove();
          }
        }
      });
  });

  $('form').submit(function(event){
    event.preventDefault();

    var values = $(this).serialize();

    var posting = $.post('/microposts', values);

    posting.done(function(data){

      var newPost = '<li id="micropost-'+data['micropost']['id']+'">';
      newPost += '<a><img class="gravatar" src="'+data['micropost']['user']['gravatar_url']+'"></a>';
      newPost += '<span class="user"><a href="/users/'+data['micropost']['user']['id']+'">'+data['micropost']['user']['name']+'</a></span>';
      newPost += '<span class="content">'+data['micropost']['content']+'</span>';
      newPost += '<span class="timestamp"> Posted at '+data['micropost']['created_at']+'<br></span>';

      if(data['micropost']['likes']===0){
        newPost += '<span class="likes_count">Be the first to like this post.</span>';
      } else {
        newPost += '<span class="likes_count">Has '+data['micropost']['likes']+' likes.</span>';
      }

      newPost += '<button class="like">Like</button>';
      newPost += '<button class="delete">Delete</button>';
      newPost += '<ul class="categories">';

      $.each(data['micropost']['categories'], function(i, val){
          newPost += '<li class="category">';
          newPost += val['title'];
          newPost += '</li>'
      });

      newPost += '</ul></li>';

      $('.microposts').prepend(newPost);
      $('form').trigger("reset");

      var categories = $('#categories').find('label').map(function(){
        return $.trim($(this).text());
      }).get();

      data['micropost']['categories'].forEach(function(category){
        if(categories.indexOf(category['title']) === -1) {
          console.log(category['id'], category['title']);
          $('#categories').append(
            '<input type="checkbox" value="'+category['id']+'" name="micropost[category_ids][]" id="micropost_category_ids_'+category['id']+'"><label for="micropost_category_ids_'+category['id']+'">'+category['title']+'</label>'
          );
        }
      });

      //leave this here for debugging
      console.log(data);
    });
  });

});
