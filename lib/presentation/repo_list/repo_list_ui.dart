import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/edit_button.dart';
import 'package:github_repo_list/presentation/common/primary_button.dart';
import 'package:github_repo_list/presentation/widgets/custom_text_field.dart';
import 'package:github_repo_list/utils/efficient_builder.dart';
import 'package:github_repo_list/presentation/repo_list/repo_list_view_model.dart';

class RepoListUi extends StatefulWidget {
  const RepoListUi({super.key});

  @override
  State<RepoListUi> createState() => _RepoListUiState();
}

class _RepoListUiState extends State<RepoListUi> {
  final viewModel = RepoListViewModel();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("State Handler"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            _buildHeaders(context),
            const SizedBox(height: 24),
            _oldPasswordTextField(context),
            const SizedBox(height: 24),
            _newPasswordTextField(context),
            const SizedBox(height: 24),
            _confirmNewPasswordTextField(context),
            const SizedBox(height: 40),
            _buildUpdateButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaders(BuildContext context) {
    return Row(
      children: [
        Text(
          "Password",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
              ),
        ),
        const Spacer(),
        EfficientBuilder(
          valueListenable: viewModel.states,
          buildFor: (state) => state.isPasswordEditMode,
          builder: (context, states, _) {
            return Visibility(
              visible: !states.isPasswordEditMode,
              child: EditButton(
                onPressed: () => viewModel.togglePasswordEditBtnState(true),
                buttonName: "Edit",
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _oldPasswordTextField(BuildContext context) {
    return EfficientBuilder(
      valueListenable: viewModel.states,
      buildWhen: (prev, now) {
        return (prev.oldPasswordErrorText != now.oldPasswordErrorText ||
            prev.isPasswordEditMode != now.isPasswordEditMode);
      },
      builder: (context, state, _) {
        return CustomTextField(
          controller: oldPasswordController,
          textFieldName: 'old Password',
          enable: state.isPasswordEditMode,
          errorText: state.oldPasswordErrorText?.getError(),
          onChanged: (password) => viewModel.onChangedOldPassword(
            oldPassword: password,
          ),
        );
      },
    );
  }

  Widget _newPasswordTextField(BuildContext context) {
    return EfficientBuilder(
      valueListenable: viewModel.states,
      buildWhen: (prev, now) {
        return (prev.newPasswordErrorText != now.newPasswordErrorText ||
            prev.isPasswordEditMode != now.isPasswordEditMode);
      },
      builder: (context, state, _) {
        return CustomTextField(
          controller: newPasswordController,
          textFieldName: 'New Password',
          enable: state.isPasswordEditMode,
          errorText: state.newPasswordErrorText?.getError(),
          onChanged: (newPassword) => viewModel.onChangedNewPassword(
            newPassword: newPassword,
          ),
        );
      },
    );
  }

  Widget _confirmNewPasswordTextField(BuildContext context) {
    return EfficientBuilder(
      valueListenable: viewModel.states,
      buildWhen: (prev, now) {
        return (prev.confirmNewPasswordErrorText !=
                now.confirmNewPasswordErrorText ||
            prev.isPasswordEditMode != now.isPasswordEditMode);
      },
      builder: (context, state, _) {
        return CustomTextField(
          controller: confirmNewPasswordController,
          textFieldName: 'Confirm New Password',
          enable: state.isPasswordEditMode,
          errorText: state.confirmNewPasswordErrorText?.getError(),
          onChanged: (confirmNewPassword) =>
              viewModel.onChangedConfirmNewPassword(
            confirmNewPassword: confirmNewPassword,
          ),
        );
      },
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return EfficientBuilder(
      valueListenable: viewModel.states,
      buildFor: (state) => state.showButton,
      builder: (context, states, _) {
        return Visibility(
          visible: states.isPasswordEditMode,
          child: PrimaryButton(
            label: 'Update Password',
            onPressed: () {},
            minWidth: double.infinity,
            isDisabled: !states.showButton,
          ),
        );
      },
    );
  }
}
