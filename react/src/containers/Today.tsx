import React, { FC, useState, useCallback, useEffect } from "react";
import { makeStyles } from "@material-ui/core/styles";

import Post from "../components/Post";
import usePostsStorage from "../services/PostsStorageAdaptor";

const useStyles = makeStyles((theme) => ({
  root: {
    display: "flex",
  },
  toolbar: theme.mixins.toolbar,
  content: {
    flexGrow: 1,
    padding: theme.spacing(3),
  },
}));

const Today: FC = () => {
  const classes = useStyles();
  const { getAllPosts, createPost, updatePost, deletePost } = usePostsStorage();
  const [allPosts, setAllPosts] = useState([]);

  const handleGetAllPosts = useCallback(() => {
    getAllPosts().then(({ allPosts }) => setAllPosts(allPosts));
  }, []);

  useEffect(handleGetAllPosts, []);

  const handleCreatePost = async () => {
    await createPost({
      authorId: "cksc2v80900075tvimijqbiua",
      title: "Best post in the word",
      textContent: "The best content of post, lorem ipsum...",
      url: "www.com",
    });
    handleGetAllPosts();
  };

  const handleEditPost = async ({ id, textContent, title, url }: any) => {
    await updatePost({ id, textContent, title, url });
    handleGetAllPosts();
  };

  const handleDeletePost = async (id: any) => {
    await deletePost(id);
    handleGetAllPosts();
  };

  return (
    <main className={classes.content}>
      <button onClick={handleCreatePost}>Create post</button>
      {allPosts.map((post: any) => (
        <Post
          post={post}
          key={post.id}
          onEditPost={handleEditPost}
          onDeletePost={handleDeletePost}
        />
      ))}
    </main>
  );
};

export default Today;
