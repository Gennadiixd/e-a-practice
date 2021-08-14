import React from "react";
import Paper from "@material-ui/core/Paper";
import Typography from "@material-ui/core/Typography";

export default function Post({ post }: any) {
  const { title, textContent } = post;

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
    </Paper>
  );
}
