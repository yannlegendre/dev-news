// import { searchbar } from '../components/searchbar'

// searchbar();

// document.querySelectorAll('.card-upvotes').forEach((upvote) => {
//   upvote.addEventListener('click', (e) => {
//     console.log("hehehe");
//   })
// })

const postComment = (articleId, content) => {
  var url = `http://localhost:3000/comments`
  var body = {
   'article_id': articleId,
   'content': content
  }
  fetch(url, { method: 'POST', body: JSON.stringify(body) })
  .then(function(response) {
    return response.blob();
  })
  .then(function(myBlob) {
    console.log(myBlob)
  });

}


document.addEventListener('keyup', (e) => {
  if (e.keyCode === 13 && document.activeElement.classList.contains("comment-input")) {
    var input = document.activeElement
    articleId = input.dataset.articleId
    content = input.value
    console.log(content)
    console.log(articleId)
    postComment(articleId, content)
  }
})


