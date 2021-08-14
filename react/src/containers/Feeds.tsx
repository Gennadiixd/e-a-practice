import React, { FC } from "react";
import useUserFeeds from "../application/use-user-feeds";

const Feeds: FC = () => {
  const { feeds } = useUserFeeds();
  console.log(feeds);
  return <div>Feeds</div>;
};

export default Feeds;
