import React from "react";
import Paper from "@material-ui/core/Paper";
import Typography from "@material-ui/core/Typography";

export default function Post({ post, onEditPost, onDeletePost }: any) {
  const { title, textContent, url } = post;

  return (
    <Paper
      style={{
        display: "flex",
        flexDirection: "column",
        padding: "20px",
        margin: "20px",
      }}
    >
      <Typography gutterBottom variant="subtitle1">
        Post title: {title}
      </Typography>
      <Typography variant="body2" gutterBottom>
        Content: {textContent}
      </Typography>

      <Typography variant="body2" gutterBottom>
        Post URL: {url}
      </Typography>
      <button
        onClick={() =>
          onEditPost({
            id: post.id,
            textContent: "Edited",
            title: "Edited",
            url: "www.com",
          })
        }
      >
        Edit post
      </button>
      <button onClick={() => onDeletePost(post.id)}>Delete post</button>
    </Paper>
  );
}
