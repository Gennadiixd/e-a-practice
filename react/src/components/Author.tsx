import React from "react";
import Typography from "@material-ui/core/Typography";

export default function Author({ author }: any) {
  const { description, title } = author;

  return (
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        paddingTop: "20px",
        border: "1px solid blue",
      }}
    >
      <Typography gutterBottom variant="subtitle1">
        Author of this feed is:
      </Typography>
      <Typography variant="body2" gutterBottom>
        {title}
        <br />
        {description}
      </Typography>
    </div>
  );
}
