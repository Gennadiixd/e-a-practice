import { useApolloClient } from "@apollo/client";

import { loader } from "graphql.macro";
import produce from "immer";

const AllPostsQuery = loader("../graphql/AllPosts.query.graphql");
const CreatePostMutation = loader("../graphql/CreatePost.mutation.graphql");
const UpdatePostMutation = loader("../graphql/UpdatePost.mutation.graphql");
const DeletePostMutation = loader("../graphql/DeletePost.mutation.graphql");

interface IPost {
  authorId?: string;
  title: string;
  textContent: string;
  url: string;
  id?: string;
}

const usePostsStorage = () => {
  const client = useApolloClient();

  const getAllPosts = async () => {
    const { data, error, loading } = await client.query({
      query: AllPostsQuery,
    });

    return { allPosts: data.allPosts, error, loading };
  };

  const adddToAllPostsCache = (post: IPost) => {
    const { allPosts }: any = client.cache.readQuery({
      query: AllPostsQuery,
    });

    const updatedPosts = produce(allPosts, (draft: any) => {
      draft.push(post);
    });

    client.cache.writeQuery({
      query: AllPostsQuery,
      data: {
        allPosts: updatedPosts,
      },
    });
  };

  const removeFromAllPostsCache = (id: any) => {
    const postId = client.cache.identify({ __typename: "Post", id });
    client.cache.evict({ id: postId });
  };

  const createPost = async ({ authorId, title, textContent, url }: IPost) => {
    const { data } = await client.mutate({
      mutation: CreatePostMutation,
      variables: {
        authorId,
        title,
        textContent,
        url,
      },
      // refetchQueries: [{ query: AllPostsQuery }],
    });

    return data.createPost;
  };

  const updatePost = async ({ id, textContent, title, url }: IPost) => {
    const { data } = await client.mutate({
      mutation: UpdatePostMutation,
      variables: {
        id,
        title,
        textContent,
        url,
      },
      // refetchQueries: [{ query: AllPostsQuery }],
    });

    return data.updatePost;
  };

  const deletePost = async (id: String) => {
    const { data } = await client.mutate({
      mutation: DeletePostMutation,
      variables: {
        id,
      },
      // refetchQueries: [{ query: AllPostsQuery }],
    });

    return data.deletePost;
  };

  const handleRemovePost = async (id: string, updateCache = true) => {
    const post = await deletePost(id);
    if (updateCache) removeFromAllPostsCache(post.id);
    return post;
  };

  const handleCreatePost = async (postData: IPost, updateCache = true) => {
    const post = await createPost(postData);
    if (updateCache) adddToAllPostsCache(post);
    return post;
  };

  return {
    getAllPosts,
    createPost: handleCreatePost,
    updatePost,
    deletePost: handleRemovePost,
  };
};

export default usePostsStorage;
