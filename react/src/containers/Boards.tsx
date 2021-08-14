import React, { FC } from "react";
import useUserBoards from "../application/use-user-boards";
import Board from "../components/Board";

const Boards: FC = () => {
  const { boards } = useUserBoards();

  return (
    <>
      {boards.map((board: any) => (
        <Board board={board} key={board.id} />
      ))}
    </>
  );
};

export default Boards;
