import React from "react";
import Paper from "@material-ui/core/Paper";
import Typography from "@material-ui/core/Typography";
import Author from "./Author";

export default function Feed({ feed }: any) {
  const { title, authors } = feed;

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
        {title}
      </Typography>
      {authors.map((author: any) => (
        <Author author={author} key={author.id} />
      ))}
    </Paper>
  );
}
