import React from "react";
import Paper from "@material-ui/core/Paper";
import Typography from "@material-ui/core/Typography";
import Post from "./Post";

export default function Board({ board }: any) {
  const { title, description, posts } = board;

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
        Board name is: {title}
      </Typography>
      <Typography variant="body2" gutterBottom>
        This board is: {description}
      </Typography>
      {posts.map((post: any) => (
        <Post post={post} key={post.id} />
      ))}
    </Paper>
  );
}
