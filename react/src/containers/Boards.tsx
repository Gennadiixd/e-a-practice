import React, { FC } from "react";
import useUserBoards from "../application/use-user-boards";

const Boards: FC = () => {
  const { boards } = useUserBoards();
  console.log(boards);
  return <div>Boards</div>;
};

export default Boards;
