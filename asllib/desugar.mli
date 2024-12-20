(******************************************************************************)
(*                                ASLRef                                      *)
(******************************************************************************)
(*
 * SPDX-FileCopyrightText: Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
 * SPDX-License-Identifier: BSD-3-Clause
 *)
(******************************************************************************)
(* Disclaimer:                                                                *)
(* This material covers both ASLv0 (viz, the existing ASL pseudocode language *)
(* which appears in the Arm Architecture Reference Manual) and ASLv1, a new,  *)
(* experimental, and as yet unreleased version of ASL.                        *)
(* This material is work in progress, more precisely at pre-Alpha quality as  *)
(* per Arm’s quality standards.                                               *)
(* In particular, this means that it would be premature to base any           *)
(* production tool development on this material.                              *)
(* However, any feedback, question, query and feature request would be most   *)
(* welcome; those can be sent to Arm’s Architecture Formal Team Lead          *)
(* Jade Alglave <jade.alglave@arm.com>, or by raising issues or PRs to the    *)
(* herdtools7 github repository.                                              *)
(******************************************************************************)

open AST

val desugar_setter :
  (identifier * expr list) annotated -> identifier list -> expr -> stmt_desc
(**
  Desugar a setter call, in particular:
  {[
  Setter(args) = rhs;               -->     Setter(rhs, args);
  Setter(args).fld = rhs;           -->     var temp = Getter(args);
                                            temp.fld = rhs;
                                            Setter(temp, args);
  Setter(args).[fld1,fld2] = rhs;   -->     var temp = Getter(args);
                                            temp.[fld1,fld2] = rhs;
                                            Setter(temp, args);
  ]}
*)
