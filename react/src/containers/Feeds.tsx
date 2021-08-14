import React, { FC } from "react";
import useUserFeeds from "../application/use-user-feeds";
import Feed from "../components/Feed";

const Feeds: FC = () => {
  const { feeds } = useUserFeeds();
  console.log(feeds);
  return (
    <>
      {feeds.map((feed: any) => (
        <Feed feed={feed} key={feed.id} />
      ))}
    </>
  );
};

export default Feeds;
